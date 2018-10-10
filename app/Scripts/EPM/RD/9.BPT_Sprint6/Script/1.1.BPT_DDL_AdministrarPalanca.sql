----------------------------------------
-- Agregar colummna para las palancas 
----------------------------------------
USE BelcorpPeru
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD TienePerfil BIT CONSTRAINT CON_ConfiguracionPais_False DEFAULT 'FALSE';
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesdeCampania'
)
BEGIN	
	ALTER TABLE ConfiguracionPais
	ADD DesdeCampania INT CONSTRAINT CON_ConfiguracionPais_Desde DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileTituloMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Logo'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD Logo VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Orden'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD Orden INT CONSTRAINT CON_ConfiguracionPais_Orden DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileTituloBanner VARCHAR(255);
END
GO
IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopSubTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopSubTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileSubTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileSubTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopFondoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopFondoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileFondoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileFondoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopLogoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopLogoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileLogoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileLogoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'UrlMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD UrlMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'OrdenBpt'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD OrdenBpt int CONSTRAINT CON_ConfiguracionPais_OrdenBpt DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.Objects 
  WHERE  Object_id = OBJECT_ID(N'dbo.ConfiguracionOfertasHome') AND Type = N'U'
)
BEGIN
	CREATE TABLE [dbo].[ConfiguracionOfertasHome](
		[ConfiguracionOfertasHomeID] [int] IDENTITY(1,1) NOT NULL,
		[ConfiguracionPaisID] [int] NOT NULL,
		[CampaniaID] [int] NOT NULL,
		[DesktopOrden] [int] NOT NULL,
		[MobileOrden] [int] NOT NULL,
		[DesktopImagenFondo] [varchar](250) NULL,
		[MobileImagenFondo] [varchar](250) NULL,
		[DesktopTitulo] [varchar](250) NULL,
		[MobileTitulo] [varchar](250) NULL,
		[DesktopSubTitulo] [varchar](250) NULL,
		[MobileSubTitulo] [varchar](250) NULL,
		[DesktopTipoPresentacion] [int] NOT NULL,
		[MobileTipoPresentacion] [int] NOT NULL,
		[DesktopTipoEstrategia] [varchar](250) NULL,
		[MobileTipoEstrategia] [varchar](250) NULL,
		[DesktopCantidadProductos] [int] NOT NULL,
		[MobileCantidadProductos] [int] NOT NULL,
		[DesktopActivo] [bit] NOT NULL,
		[MobileActivo] [bit] NOT NULL,
		[UrlSeccion] [varchar](250) NULL,
		[DesktopOrdenBpt] [int] NOT NULL,
		[MobileOrdenBpt] [int] NOT NULL
	)

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_ConfiguracionPaisID]  DEFAULT ((0)) FOR [ConfiguracionPaisID]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_CampaniaID]  DEFAULT ((0)) FOR [CampaniaID]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopOrden]  DEFAULT ((0)) FOR [DesktopOrden]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileOrden]  DEFAULT ((0)) FOR [MobileOrden]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopTipoPresentacion]  DEFAULT ((0)) FOR [DesktopTipoPresentacion]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileTipoPresentacion]  DEFAULT ((0)) FOR [MobileTipoPresentacion]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopCantidadProductos]  DEFAULT ((0)) FOR [DesktopCantidadProductos]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileCantidadProductos]  DEFAULT ((0)) FOR [MobileCantidadProductos]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopActivo]  DEFAULT ((0)) FOR [DesktopActivo]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileActivo]  DEFAULT ((0)) FOR [MobileActivo]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopOrdenBpt]  DEFAULT ((0)) FOR [DesktopOrdenBpt]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileOrdenBpt]  DEFAULT ((0)) FOR [MobileOrdenBpt]
	
END

GO

/*end*/

USE BelcorpMexico
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD TienePerfil BIT CONSTRAINT CON_ConfiguracionPais_False DEFAULT 'FALSE';
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesdeCampania'
)
BEGIN	
	ALTER TABLE ConfiguracionPais
	ADD DesdeCampania INT CONSTRAINT CON_ConfiguracionPais_Desde DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileTituloMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Logo'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD Logo VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Orden'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD Orden INT CONSTRAINT CON_ConfiguracionPais_Orden DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileTituloBanner VARCHAR(255);
END
GO
IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopSubTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopSubTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileSubTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileSubTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopFondoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopFondoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileFondoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileFondoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopLogoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopLogoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileLogoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileLogoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'UrlMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD UrlMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'OrdenBpt'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD OrdenBpt int CONSTRAINT CON_ConfiguracionPais_OrdenBpt DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.Objects 
  WHERE  Object_id = OBJECT_ID(N'dbo.ConfiguracionOfertasHome') AND Type = N'U'
)
BEGIN
	CREATE TABLE [dbo].[ConfiguracionOfertasHome](
		[ConfiguracionOfertasHomeID] [int] IDENTITY(1,1) NOT NULL,
		[ConfiguracionPaisID] [int] NOT NULL,
		[CampaniaID] [int] NOT NULL,
		[DesktopOrden] [int] NOT NULL,
		[MobileOrden] [int] NOT NULL,
		[DesktopImagenFondo] [varchar](250) NULL,
		[MobileImagenFondo] [varchar](250) NULL,
		[DesktopTitulo] [varchar](250) NULL,
		[MobileTitulo] [varchar](250) NULL,
		[DesktopSubTitulo] [varchar](250) NULL,
		[MobileSubTitulo] [varchar](250) NULL,
		[DesktopTipoPresentacion] [int] NOT NULL,
		[MobileTipoPresentacion] [int] NOT NULL,
		[DesktopTipoEstrategia] [varchar](250) NULL,
		[MobileTipoEstrategia] [varchar](250) NULL,
		[DesktopCantidadProductos] [int] NOT NULL,
		[MobileCantidadProductos] [int] NOT NULL,
		[DesktopActivo] [bit] NOT NULL,
		[MobileActivo] [bit] NOT NULL,
		[UrlSeccion] [varchar](250) NULL,
		[DesktopOrdenBpt] [int] NOT NULL,
		[MobileOrdenBpt] [int] NOT NULL
	)

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_ConfiguracionPaisID]  DEFAULT ((0)) FOR [ConfiguracionPaisID]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_CampaniaID]  DEFAULT ((0)) FOR [CampaniaID]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopOrden]  DEFAULT ((0)) FOR [DesktopOrden]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileOrden]  DEFAULT ((0)) FOR [MobileOrden]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopTipoPresentacion]  DEFAULT ((0)) FOR [DesktopTipoPresentacion]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileTipoPresentacion]  DEFAULT ((0)) FOR [MobileTipoPresentacion]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopCantidadProductos]  DEFAULT ((0)) FOR [DesktopCantidadProductos]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileCantidadProductos]  DEFAULT ((0)) FOR [MobileCantidadProductos]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopActivo]  DEFAULT ((0)) FOR [DesktopActivo]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileActivo]  DEFAULT ((0)) FOR [MobileActivo]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopOrdenBpt]  DEFAULT ((0)) FOR [DesktopOrdenBpt]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileOrdenBpt]  DEFAULT ((0)) FOR [MobileOrdenBpt]

END

GO

/*end*/

USE BelcorpColombia
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD TienePerfil BIT CONSTRAINT CON_ConfiguracionPais_False DEFAULT 'FALSE';
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesdeCampania'
)
BEGIN	
	ALTER TABLE ConfiguracionPais
	ADD DesdeCampania INT CONSTRAINT CON_ConfiguracionPais_Desde DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileTituloMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Logo'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD Logo VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Orden'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD Orden INT CONSTRAINT CON_ConfiguracionPais_Orden DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileTituloBanner VARCHAR(255);
END
GO
IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopSubTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopSubTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileSubTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileSubTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopFondoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopFondoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileFondoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileFondoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopLogoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopLogoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileLogoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileLogoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'UrlMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD UrlMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'OrdenBpt'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD OrdenBpt int CONSTRAINT CON_ConfiguracionPais_OrdenBpt DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.Objects 
  WHERE  Object_id = OBJECT_ID(N'dbo.ConfiguracionOfertasHome') AND Type = N'U'
)
BEGIN
	CREATE TABLE [dbo].[ConfiguracionOfertasHome](
		[ConfiguracionOfertasHomeID] [int] IDENTITY(1,1) NOT NULL,
		[ConfiguracionPaisID] [int] NOT NULL,
		[CampaniaID] [int] NOT NULL,
		[DesktopOrden] [int] NOT NULL,
		[MobileOrden] [int] NOT NULL,
		[DesktopImagenFondo] [varchar](250) NULL,
		[MobileImagenFondo] [varchar](250) NULL,
		[DesktopTitulo] [varchar](250) NULL,
		[MobileTitulo] [varchar](250) NULL,
		[DesktopSubTitulo] [varchar](250) NULL,
		[MobileSubTitulo] [varchar](250) NULL,
		[DesktopTipoPresentacion] [int] NOT NULL,
		[MobileTipoPresentacion] [int] NOT NULL,
		[DesktopTipoEstrategia] [varchar](250) NULL,
		[MobileTipoEstrategia] [varchar](250) NULL,
		[DesktopCantidadProductos] [int] NOT NULL,
		[MobileCantidadProductos] [int] NOT NULL,
		[DesktopActivo] [bit] NOT NULL,
		[MobileActivo] [bit] NOT NULL,
		[UrlSeccion] [varchar](250) NULL,
		[DesktopOrdenBpt] [int] NOT NULL,
		[MobileOrdenBpt] [int] NOT NULL
	)

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_ConfiguracionPaisID]  DEFAULT ((0)) FOR [ConfiguracionPaisID]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_CampaniaID]  DEFAULT ((0)) FOR [CampaniaID]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopOrden]  DEFAULT ((0)) FOR [DesktopOrden]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileOrden]  DEFAULT ((0)) FOR [MobileOrden]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopTipoPresentacion]  DEFAULT ((0)) FOR [DesktopTipoPresentacion]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileTipoPresentacion]  DEFAULT ((0)) FOR [MobileTipoPresentacion]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopCantidadProductos]  DEFAULT ((0)) FOR [DesktopCantidadProductos]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileCantidadProductos]  DEFAULT ((0)) FOR [MobileCantidadProductos]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopActivo]  DEFAULT ((0)) FOR [DesktopActivo]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileActivo]  DEFAULT ((0)) FOR [MobileActivo]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopOrdenBpt]  DEFAULT ((0)) FOR [DesktopOrdenBpt]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileOrdenBpt]  DEFAULT ((0)) FOR [MobileOrdenBpt]

END

GO

/*end*/

USE BelcorpVenezuela
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD TienePerfil BIT CONSTRAINT CON_ConfiguracionPais_False DEFAULT 'FALSE';
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesdeCampania'
)
BEGIN	
	ALTER TABLE ConfiguracionPais
	ADD DesdeCampania INT CONSTRAINT CON_ConfiguracionPais_Desde DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileTituloMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Logo'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD Logo VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Orden'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD Orden INT CONSTRAINT CON_ConfiguracionPais_Orden DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileTituloBanner VARCHAR(255);
END
GO
IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopSubTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopSubTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileSubTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileSubTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopFondoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopFondoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileFondoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileFondoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopLogoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopLogoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileLogoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileLogoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'UrlMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD UrlMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'OrdenBpt'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD OrdenBpt int CONSTRAINT CON_ConfiguracionPais_OrdenBpt DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.Objects 
  WHERE  Object_id = OBJECT_ID(N'dbo.ConfiguracionOfertasHome') AND Type = N'U'
)
BEGIN
	CREATE TABLE [dbo].[ConfiguracionOfertasHome](
		[ConfiguracionOfertasHomeID] [int] IDENTITY(1,1) NOT NULL,
		[ConfiguracionPaisID] [int] NOT NULL,
		[CampaniaID] [int] NOT NULL,
		[DesktopOrden] [int] NOT NULL,
		[MobileOrden] [int] NOT NULL,
		[DesktopImagenFondo] [varchar](250) NULL,
		[MobileImagenFondo] [varchar](250) NULL,
		[DesktopTitulo] [varchar](250) NULL,
		[MobileTitulo] [varchar](250) NULL,
		[DesktopSubTitulo] [varchar](250) NULL,
		[MobileSubTitulo] [varchar](250) NULL,
		[DesktopTipoPresentacion] [int] NOT NULL,
		[MobileTipoPresentacion] [int] NOT NULL,
		[DesktopTipoEstrategia] [varchar](250) NULL,
		[MobileTipoEstrategia] [varchar](250) NULL,
		[DesktopCantidadProductos] [int] NOT NULL,
		[MobileCantidadProductos] [int] NOT NULL,
		[DesktopActivo] [bit] NOT NULL,
		[MobileActivo] [bit] NOT NULL,
		[UrlSeccion] [varchar](250) NULL,
		[DesktopOrdenBpt] [int] NOT NULL,
		[MobileOrdenBpt] [int] NOT NULL
	)

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_ConfiguracionPaisID]  DEFAULT ((0)) FOR [ConfiguracionPaisID]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_CampaniaID]  DEFAULT ((0)) FOR [CampaniaID]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopOrden]  DEFAULT ((0)) FOR [DesktopOrden]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileOrden]  DEFAULT ((0)) FOR [MobileOrden]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopTipoPresentacion]  DEFAULT ((0)) FOR [DesktopTipoPresentacion]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileTipoPresentacion]  DEFAULT ((0)) FOR [MobileTipoPresentacion]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopCantidadProductos]  DEFAULT ((0)) FOR [DesktopCantidadProductos]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileCantidadProductos]  DEFAULT ((0)) FOR [MobileCantidadProductos]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopActivo]  DEFAULT ((0)) FOR [DesktopActivo]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileActivo]  DEFAULT ((0)) FOR [MobileActivo]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopOrdenBpt]  DEFAULT ((0)) FOR [DesktopOrdenBpt]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileOrdenBpt]  DEFAULT ((0)) FOR [MobileOrdenBpt]
END

GO

/*end*/

USE BelcorpSalvador
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD TienePerfil BIT CONSTRAINT CON_ConfiguracionPais_False DEFAULT 'FALSE';
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesdeCampania'
)
BEGIN	
	ALTER TABLE ConfiguracionPais
	ADD DesdeCampania INT CONSTRAINT CON_ConfiguracionPais_Desde DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileTituloMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Logo'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD Logo VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Orden'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD Orden INT CONSTRAINT CON_ConfiguracionPais_Orden DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileTituloBanner VARCHAR(255);
END
GO
IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopSubTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopSubTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileSubTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileSubTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopFondoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopFondoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileFondoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileFondoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopLogoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopLogoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileLogoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileLogoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'UrlMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD UrlMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'OrdenBpt'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD OrdenBpt int CONSTRAINT CON_ConfiguracionPais_OrdenBpt DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.Objects 
  WHERE  Object_id = OBJECT_ID(N'dbo.ConfiguracionOfertasHome') AND Type = N'U'
)
BEGIN
	CREATE TABLE [dbo].[ConfiguracionOfertasHome](
		[ConfiguracionOfertasHomeID] [int] IDENTITY(1,1) NOT NULL,
		[ConfiguracionPaisID] [int] NOT NULL,
		[CampaniaID] [int] NOT NULL,
		[DesktopOrden] [int] NOT NULL,
		[MobileOrden] [int] NOT NULL,
		[DesktopImagenFondo] [varchar](250) NULL,
		[MobileImagenFondo] [varchar](250) NULL,
		[DesktopTitulo] [varchar](250) NULL,
		[MobileTitulo] [varchar](250) NULL,
		[DesktopSubTitulo] [varchar](250) NULL,
		[MobileSubTitulo] [varchar](250) NULL,
		[DesktopTipoPresentacion] [int] NOT NULL,
		[MobileTipoPresentacion] [int] NOT NULL,
		[DesktopTipoEstrategia] [varchar](250) NULL,
		[MobileTipoEstrategia] [varchar](250) NULL,
		[DesktopCantidadProductos] [int] NOT NULL,
		[MobileCantidadProductos] [int] NOT NULL,
		[DesktopActivo] [bit] NOT NULL,
		[MobileActivo] [bit] NOT NULL,
		[UrlSeccion] [varchar](250) NULL,
		[DesktopOrdenBpt] [int] NOT NULL,
		[MobileOrdenBpt] [int] NOT NULL
	)

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_ConfiguracionPaisID]  DEFAULT ((0)) FOR [ConfiguracionPaisID]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_CampaniaID]  DEFAULT ((0)) FOR [CampaniaID]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopOrden]  DEFAULT ((0)) FOR [DesktopOrden]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileOrden]  DEFAULT ((0)) FOR [MobileOrden]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopTipoPresentacion]  DEFAULT ((0)) FOR [DesktopTipoPresentacion]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileTipoPresentacion]  DEFAULT ((0)) FOR [MobileTipoPresentacion]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopCantidadProductos]  DEFAULT ((0)) FOR [DesktopCantidadProductos]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileCantidadProductos]  DEFAULT ((0)) FOR [MobileCantidadProductos]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopActivo]  DEFAULT ((0)) FOR [DesktopActivo]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileActivo]  DEFAULT ((0)) FOR [MobileActivo]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopOrdenBpt]  DEFAULT ((0)) FOR [DesktopOrdenBpt]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileOrdenBpt]  DEFAULT ((0)) FOR [MobileOrdenBpt]

END

GO

/*end*/

USE BelcorpPuertoRico
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD TienePerfil BIT CONSTRAINT CON_ConfiguracionPais_False DEFAULT 'FALSE';
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesdeCampania'
)
BEGIN	
	ALTER TABLE ConfiguracionPais
	ADD DesdeCampania INT CONSTRAINT CON_ConfiguracionPais_Desde DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileTituloMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Logo'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD Logo VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Orden'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD Orden INT CONSTRAINT CON_ConfiguracionPais_Orden DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileTituloBanner VARCHAR(255);
END
GO
IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopSubTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopSubTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileSubTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileSubTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopFondoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopFondoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileFondoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileFondoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopLogoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopLogoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileLogoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileLogoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'UrlMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD UrlMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'OrdenBpt'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD OrdenBpt int CONSTRAINT CON_ConfiguracionPais_OrdenBpt DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.Objects 
  WHERE  Object_id = OBJECT_ID(N'dbo.ConfiguracionOfertasHome') AND Type = N'U'
)
BEGIN
	CREATE TABLE [dbo].[ConfiguracionOfertasHome](
		[ConfiguracionOfertasHomeID] [int] IDENTITY(1,1) NOT NULL,
		[ConfiguracionPaisID] [int] NOT NULL,
		[CampaniaID] [int] NOT NULL,
		[DesktopOrden] [int] NOT NULL,
		[MobileOrden] [int] NOT NULL,
		[DesktopImagenFondo] [varchar](250) NULL,
		[MobileImagenFondo] [varchar](250) NULL,
		[DesktopTitulo] [varchar](250) NULL,
		[MobileTitulo] [varchar](250) NULL,
		[DesktopSubTitulo] [varchar](250) NULL,
		[MobileSubTitulo] [varchar](250) NULL,
		[DesktopTipoPresentacion] [int] NOT NULL,
		[MobileTipoPresentacion] [int] NOT NULL,
		[DesktopTipoEstrategia] [varchar](250) NULL,
		[MobileTipoEstrategia] [varchar](250) NULL,
		[DesktopCantidadProductos] [int] NOT NULL,
		[MobileCantidadProductos] [int] NOT NULL,
		[DesktopActivo] [bit] NOT NULL,
		[MobileActivo] [bit] NOT NULL,
		[UrlSeccion] [varchar](250) NULL,
		[DesktopOrdenBpt] [int] NOT NULL,
		[MobileOrdenBpt] [int] NOT NULL
	)

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_ConfiguracionPaisID]  DEFAULT ((0)) FOR [ConfiguracionPaisID]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_CampaniaID]  DEFAULT ((0)) FOR [CampaniaID]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopOrden]  DEFAULT ((0)) FOR [DesktopOrden]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileOrden]  DEFAULT ((0)) FOR [MobileOrden]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopTipoPresentacion]  DEFAULT ((0)) FOR [DesktopTipoPresentacion]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileTipoPresentacion]  DEFAULT ((0)) FOR [MobileTipoPresentacion]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopCantidadProductos]  DEFAULT ((0)) FOR [DesktopCantidadProductos]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileCantidadProductos]  DEFAULT ((0)) FOR [MobileCantidadProductos]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopActivo]  DEFAULT ((0)) FOR [DesktopActivo]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileActivo]  DEFAULT ((0)) FOR [MobileActivo]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopOrdenBpt]  DEFAULT ((0)) FOR [DesktopOrdenBpt]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileOrdenBpt]  DEFAULT ((0)) FOR [MobileOrdenBpt]

END

GO

/*end*/

USE BelcorpPanama
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD TienePerfil BIT CONSTRAINT CON_ConfiguracionPais_False DEFAULT 'FALSE';
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesdeCampania'
)
BEGIN	
	ALTER TABLE ConfiguracionPais
	ADD DesdeCampania INT CONSTRAINT CON_ConfiguracionPais_Desde DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileTituloMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Logo'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD Logo VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Orden'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD Orden INT CONSTRAINT CON_ConfiguracionPais_Orden DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileTituloBanner VARCHAR(255);
END
GO
IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopSubTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopSubTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileSubTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileSubTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopFondoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopFondoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileFondoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileFondoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopLogoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopLogoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileLogoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileLogoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'UrlMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD UrlMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'OrdenBpt'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD OrdenBpt int CONSTRAINT CON_ConfiguracionPais_OrdenBpt DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.Objects 
  WHERE  Object_id = OBJECT_ID(N'dbo.ConfiguracionOfertasHome') AND Type = N'U'
)
BEGIN
	CREATE TABLE [dbo].[ConfiguracionOfertasHome](
		[ConfiguracionOfertasHomeID] [int] IDENTITY(1,1) NOT NULL,
		[ConfiguracionPaisID] [int] NOT NULL,
		[CampaniaID] [int] NOT NULL,
		[DesktopOrden] [int] NOT NULL,
		[MobileOrden] [int] NOT NULL,
		[DesktopImagenFondo] [varchar](250) NULL,
		[MobileImagenFondo] [varchar](250) NULL,
		[DesktopTitulo] [varchar](250) NULL,
		[MobileTitulo] [varchar](250) NULL,
		[DesktopSubTitulo] [varchar](250) NULL,
		[MobileSubTitulo] [varchar](250) NULL,
		[DesktopTipoPresentacion] [int] NOT NULL,
		[MobileTipoPresentacion] [int] NOT NULL,
		[DesktopTipoEstrategia] [varchar](250) NULL,
		[MobileTipoEstrategia] [varchar](250) NULL,
		[DesktopCantidadProductos] [int] NOT NULL,
		[MobileCantidadProductos] [int] NOT NULL,
		[DesktopActivo] [bit] NOT NULL,
		[MobileActivo] [bit] NOT NULL,
		[UrlSeccion] [varchar](250) NULL,
		[DesktopOrdenBpt] [int] NOT NULL,
		[MobileOrdenBpt] [int] NOT NULL
	)

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_ConfiguracionPaisID]  DEFAULT ((0)) FOR [ConfiguracionPaisID]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_CampaniaID]  DEFAULT ((0)) FOR [CampaniaID]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopOrden]  DEFAULT ((0)) FOR [DesktopOrden]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileOrden]  DEFAULT ((0)) FOR [MobileOrden]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopTipoPresentacion]  DEFAULT ((0)) FOR [DesktopTipoPresentacion]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileTipoPresentacion]  DEFAULT ((0)) FOR [MobileTipoPresentacion]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopCantidadProductos]  DEFAULT ((0)) FOR [DesktopCantidadProductos]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileCantidadProductos]  DEFAULT ((0)) FOR [MobileCantidadProductos]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopActivo]  DEFAULT ((0)) FOR [DesktopActivo]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileActivo]  DEFAULT ((0)) FOR [MobileActivo]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopOrdenBpt]  DEFAULT ((0)) FOR [DesktopOrdenBpt]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileOrdenBpt]  DEFAULT ((0)) FOR [MobileOrdenBpt]

END

GO

/*end*/

USE BelcorpGuatemala
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD TienePerfil BIT CONSTRAINT CON_ConfiguracionPais_False DEFAULT 'FALSE';
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesdeCampania'
)
BEGIN	
	ALTER TABLE ConfiguracionPais
	ADD DesdeCampania INT CONSTRAINT CON_ConfiguracionPais_Desde DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileTituloMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Logo'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD Logo VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Orden'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD Orden INT CONSTRAINT CON_ConfiguracionPais_Orden DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileTituloBanner VARCHAR(255);
END
GO
IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopSubTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopSubTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileSubTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileSubTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopFondoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopFondoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileFondoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileFondoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopLogoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopLogoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileLogoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileLogoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'UrlMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD UrlMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'OrdenBpt'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD OrdenBpt int CONSTRAINT CON_ConfiguracionPais_OrdenBpt DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.Objects 
  WHERE  Object_id = OBJECT_ID(N'dbo.ConfiguracionOfertasHome') AND Type = N'U'
)
BEGIN
	CREATE TABLE [dbo].[ConfiguracionOfertasHome](
		[ConfiguracionOfertasHomeID] [int] IDENTITY(1,1) NOT NULL,
		[ConfiguracionPaisID] [int] NOT NULL,
		[CampaniaID] [int] NOT NULL,
		[DesktopOrden] [int] NOT NULL,
		[MobileOrden] [int] NOT NULL,
		[DesktopImagenFondo] [varchar](250) NULL,
		[MobileImagenFondo] [varchar](250) NULL,
		[DesktopTitulo] [varchar](250) NULL,
		[MobileTitulo] [varchar](250) NULL,
		[DesktopSubTitulo] [varchar](250) NULL,
		[MobileSubTitulo] [varchar](250) NULL,
		[DesktopTipoPresentacion] [int] NOT NULL,
		[MobileTipoPresentacion] [int] NOT NULL,
		[DesktopTipoEstrategia] [varchar](250) NULL,
		[MobileTipoEstrategia] [varchar](250) NULL,
		[DesktopCantidadProductos] [int] NOT NULL,
		[MobileCantidadProductos] [int] NOT NULL,
		[DesktopActivo] [bit] NOT NULL,
		[MobileActivo] [bit] NOT NULL,
		[UrlSeccion] [varchar](250) NULL,
		[DesktopOrdenBpt] [int] NOT NULL,
		[MobileOrdenBpt] [int] NOT NULL
	)

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_ConfiguracionPaisID]  DEFAULT ((0)) FOR [ConfiguracionPaisID]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_CampaniaID]  DEFAULT ((0)) FOR [CampaniaID]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopOrden]  DEFAULT ((0)) FOR [DesktopOrden]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileOrden]  DEFAULT ((0)) FOR [MobileOrden]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopTipoPresentacion]  DEFAULT ((0)) FOR [DesktopTipoPresentacion]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileTipoPresentacion]  DEFAULT ((0)) FOR [MobileTipoPresentacion]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopCantidadProductos]  DEFAULT ((0)) FOR [DesktopCantidadProductos]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileCantidadProductos]  DEFAULT ((0)) FOR [MobileCantidadProductos]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopActivo]  DEFAULT ((0)) FOR [DesktopActivo]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileActivo]  DEFAULT ((0)) FOR [MobileActivo]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopOrdenBpt]  DEFAULT ((0)) FOR [DesktopOrdenBpt]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileOrdenBpt]  DEFAULT ((0)) FOR [MobileOrdenBpt]

END

GO

/*end*/

USE BelcorpEcuador
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD TienePerfil BIT CONSTRAINT CON_ConfiguracionPais_False DEFAULT 'FALSE';
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesdeCampania'
)
BEGIN	
	ALTER TABLE ConfiguracionPais
	ADD DesdeCampania INT CONSTRAINT CON_ConfiguracionPais_Desde DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileTituloMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Logo'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD Logo VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Orden'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD Orden INT CONSTRAINT CON_ConfiguracionPais_Orden DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileTituloBanner VARCHAR(255);
END
GO
IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopSubTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopSubTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileSubTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileSubTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopFondoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopFondoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileFondoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileFondoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopLogoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopLogoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileLogoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileLogoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'UrlMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD UrlMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'OrdenBpt'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD OrdenBpt int CONSTRAINT CON_ConfiguracionPais_OrdenBpt DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.Objects 
  WHERE  Object_id = OBJECT_ID(N'dbo.ConfiguracionOfertasHome') AND Type = N'U'
)
BEGIN
	CREATE TABLE [dbo].[ConfiguracionOfertasHome](
		[ConfiguracionOfertasHomeID] [int] IDENTITY(1,1) NOT NULL,
		[ConfiguracionPaisID] [int] NOT NULL,
		[CampaniaID] [int] NOT NULL,
		[DesktopOrden] [int] NOT NULL,
		[MobileOrden] [int] NOT NULL,
		[DesktopImagenFondo] [varchar](250) NULL,
		[MobileImagenFondo] [varchar](250) NULL,
		[DesktopTitulo] [varchar](250) NULL,
		[MobileTitulo] [varchar](250) NULL,
		[DesktopSubTitulo] [varchar](250) NULL,
		[MobileSubTitulo] [varchar](250) NULL,
		[DesktopTipoPresentacion] [int] NOT NULL,
		[MobileTipoPresentacion] [int] NOT NULL,
		[DesktopTipoEstrategia] [varchar](250) NULL,
		[MobileTipoEstrategia] [varchar](250) NULL,
		[DesktopCantidadProductos] [int] NOT NULL,
		[MobileCantidadProductos] [int] NOT NULL,
		[DesktopActivo] [bit] NOT NULL,
		[MobileActivo] [bit] NOT NULL,
		[UrlSeccion] [varchar](250) NULL,
		[DesktopOrdenBpt] [int] NOT NULL,
		[MobileOrdenBpt] [int] NOT NULL
	)

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_ConfiguracionPaisID]  DEFAULT ((0)) FOR [ConfiguracionPaisID]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_CampaniaID]  DEFAULT ((0)) FOR [CampaniaID]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopOrden]  DEFAULT ((0)) FOR [DesktopOrden]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileOrden]  DEFAULT ((0)) FOR [MobileOrden]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopTipoPresentacion]  DEFAULT ((0)) FOR [DesktopTipoPresentacion]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileTipoPresentacion]  DEFAULT ((0)) FOR [MobileTipoPresentacion]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopCantidadProductos]  DEFAULT ((0)) FOR [DesktopCantidadProductos]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileCantidadProductos]  DEFAULT ((0)) FOR [MobileCantidadProductos]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopActivo]  DEFAULT ((0)) FOR [DesktopActivo]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileActivo]  DEFAULT ((0)) FOR [MobileActivo]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopOrdenBpt]  DEFAULT ((0)) FOR [DesktopOrdenBpt]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileOrdenBpt]  DEFAULT ((0)) FOR [MobileOrdenBpt]

END

GO

/*end*/

USE BelcorpDominicana
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD TienePerfil BIT CONSTRAINT CON_ConfiguracionPais_False DEFAULT 'FALSE';
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesdeCampania'
)
BEGIN	
	ALTER TABLE ConfiguracionPais
	ADD DesdeCampania INT CONSTRAINT CON_ConfiguracionPais_Desde DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileTituloMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Logo'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD Logo VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Orden'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD Orden INT CONSTRAINT CON_ConfiguracionPais_Orden DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileTituloBanner VARCHAR(255);
END
GO
IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopSubTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopSubTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileSubTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileSubTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopFondoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopFondoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileFondoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileFondoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopLogoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopLogoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileLogoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileLogoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'UrlMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD UrlMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'OrdenBpt'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD OrdenBpt int CONSTRAINT CON_ConfiguracionPais_OrdenBpt DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.Objects 
  WHERE  Object_id = OBJECT_ID(N'dbo.ConfiguracionOfertasHome') AND Type = N'U'
)
BEGIN
	CREATE TABLE [dbo].[ConfiguracionOfertasHome](
		[ConfiguracionOfertasHomeID] [int] IDENTITY(1,1) NOT NULL,
		[ConfiguracionPaisID] [int] NOT NULL,
		[CampaniaID] [int] NOT NULL,
		[DesktopOrden] [int] NOT NULL,
		[MobileOrden] [int] NOT NULL,
		[DesktopImagenFondo] [varchar](250) NULL,
		[MobileImagenFondo] [varchar](250) NULL,
		[DesktopTitulo] [varchar](250) NULL,
		[MobileTitulo] [varchar](250) NULL,
		[DesktopSubTitulo] [varchar](250) NULL,
		[MobileSubTitulo] [varchar](250) NULL,
		[DesktopTipoPresentacion] [int] NOT NULL,
		[MobileTipoPresentacion] [int] NOT NULL,
		[DesktopTipoEstrategia] [varchar](250) NULL,
		[MobileTipoEstrategia] [varchar](250) NULL,
		[DesktopCantidadProductos] [int] NOT NULL,
		[MobileCantidadProductos] [int] NOT NULL,
		[DesktopActivo] [bit] NOT NULL,
		[MobileActivo] [bit] NOT NULL,
		[UrlSeccion] [varchar](250) NULL,
		[DesktopOrdenBpt] [int] NOT NULL,
		[MobileOrdenBpt] [int] NOT NULL
	)

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_ConfiguracionPaisID]  DEFAULT ((0)) FOR [ConfiguracionPaisID]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_CampaniaID]  DEFAULT ((0)) FOR [CampaniaID]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopOrden]  DEFAULT ((0)) FOR [DesktopOrden]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileOrden]  DEFAULT ((0)) FOR [MobileOrden]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopTipoPresentacion]  DEFAULT ((0)) FOR [DesktopTipoPresentacion]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileTipoPresentacion]  DEFAULT ((0)) FOR [MobileTipoPresentacion]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopCantidadProductos]  DEFAULT ((0)) FOR [DesktopCantidadProductos]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileCantidadProductos]  DEFAULT ((0)) FOR [MobileCantidadProductos]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopActivo]  DEFAULT ((0)) FOR [DesktopActivo]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileActivo]  DEFAULT ((0)) FOR [MobileActivo]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopOrdenBpt]  DEFAULT ((0)) FOR [DesktopOrdenBpt]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileOrdenBpt]  DEFAULT ((0)) FOR [MobileOrdenBpt]

END

GO

/*end*/

USE BelcorpCostaRica
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD TienePerfil BIT CONSTRAINT CON_ConfiguracionPais_False DEFAULT 'FALSE';
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesdeCampania'
)
BEGIN	
	ALTER TABLE ConfiguracionPais
	ADD DesdeCampania INT CONSTRAINT CON_ConfiguracionPais_Desde DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileTituloMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Logo'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD Logo VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Orden'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD Orden INT CONSTRAINT CON_ConfiguracionPais_Orden DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileTituloBanner VARCHAR(255);
END
GO
IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopSubTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopSubTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileSubTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileSubTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopFondoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopFondoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileFondoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileFondoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopLogoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopLogoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileLogoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileLogoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'UrlMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD UrlMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'OrdenBpt'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD OrdenBpt int CONSTRAINT CON_ConfiguracionPais_OrdenBpt DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.Objects 
  WHERE  Object_id = OBJECT_ID(N'dbo.ConfiguracionOfertasHome') AND Type = N'U'
)
BEGIN
	CREATE TABLE [dbo].[ConfiguracionOfertasHome](
		[ConfiguracionOfertasHomeID] [int] IDENTITY(1,1) NOT NULL,
		[ConfiguracionPaisID] [int] NOT NULL,
		[CampaniaID] [int] NOT NULL,
		[DesktopOrden] [int] NOT NULL,
		[MobileOrden] [int] NOT NULL,
		[DesktopImagenFondo] [varchar](250) NULL,
		[MobileImagenFondo] [varchar](250) NULL,
		[DesktopTitulo] [varchar](250) NULL,
		[MobileTitulo] [varchar](250) NULL,
		[DesktopSubTitulo] [varchar](250) NULL,
		[MobileSubTitulo] [varchar](250) NULL,
		[DesktopTipoPresentacion] [int] NOT NULL,
		[MobileTipoPresentacion] [int] NOT NULL,
		[DesktopTipoEstrategia] [varchar](250) NULL,
		[MobileTipoEstrategia] [varchar](250) NULL,
		[DesktopCantidadProductos] [int] NOT NULL,
		[MobileCantidadProductos] [int] NOT NULL,
		[DesktopActivo] [bit] NOT NULL,
		[MobileActivo] [bit] NOT NULL,
		[UrlSeccion] [varchar](250) NULL,
		[DesktopOrdenBpt] [int] NOT NULL,
		[MobileOrdenBpt] [int] NOT NULL
	)

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_ConfiguracionPaisID]  DEFAULT ((0)) FOR [ConfiguracionPaisID]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_CampaniaID]  DEFAULT ((0)) FOR [CampaniaID]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopOrden]  DEFAULT ((0)) FOR [DesktopOrden]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileOrden]  DEFAULT ((0)) FOR [MobileOrden]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopTipoPresentacion]  DEFAULT ((0)) FOR [DesktopTipoPresentacion]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileTipoPresentacion]  DEFAULT ((0)) FOR [MobileTipoPresentacion]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopCantidadProductos]  DEFAULT ((0)) FOR [DesktopCantidadProductos]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileCantidadProductos]  DEFAULT ((0)) FOR [MobileCantidadProductos]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopActivo]  DEFAULT ((0)) FOR [DesktopActivo]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileActivo]  DEFAULT ((0)) FOR [MobileActivo]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopOrdenBpt]  DEFAULT ((0)) FOR [DesktopOrdenBpt]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileOrdenBpt]  DEFAULT ((0)) FOR [MobileOrdenBpt]

END

GO

/*end*/

USE BelcorpChile
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD TienePerfil BIT CONSTRAINT CON_ConfiguracionPais_False DEFAULT 'FALSE';
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesdeCampania'
)
BEGIN	
	ALTER TABLE ConfiguracionPais
	ADD DesdeCampania INT CONSTRAINT CON_ConfiguracionPais_Desde DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileTituloMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Logo'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD Logo VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Orden'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD Orden INT CONSTRAINT CON_ConfiguracionPais_Orden DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileTituloBanner VARCHAR(255);
END
GO
IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopSubTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopSubTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileSubTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileSubTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopFondoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopFondoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileFondoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileFondoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopLogoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopLogoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileLogoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileLogoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'UrlMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD UrlMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'OrdenBpt'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD OrdenBpt int CONSTRAINT CON_ConfiguracionPais_OrdenBpt DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.Objects 
  WHERE  Object_id = OBJECT_ID(N'dbo.ConfiguracionOfertasHome') AND Type = N'U'
)
BEGIN
	CREATE TABLE [dbo].[ConfiguracionOfertasHome](
		[ConfiguracionOfertasHomeID] [int] IDENTITY(1,1) NOT NULL,
		[ConfiguracionPaisID] [int] NOT NULL,
		[CampaniaID] [int] NOT NULL,
		[DesktopOrden] [int] NOT NULL,
		[MobileOrden] [int] NOT NULL,
		[DesktopImagenFondo] [varchar](250) NULL,
		[MobileImagenFondo] [varchar](250) NULL,
		[DesktopTitulo] [varchar](250) NULL,
		[MobileTitulo] [varchar](250) NULL,
		[DesktopSubTitulo] [varchar](250) NULL,
		[MobileSubTitulo] [varchar](250) NULL,
		[DesktopTipoPresentacion] [int] NOT NULL,
		[MobileTipoPresentacion] [int] NOT NULL,
		[DesktopTipoEstrategia] [varchar](250) NULL,
		[MobileTipoEstrategia] [varchar](250) NULL,
		[DesktopCantidadProductos] [int] NOT NULL,
		[MobileCantidadProductos] [int] NOT NULL,
		[DesktopActivo] [bit] NOT NULL,
		[MobileActivo] [bit] NOT NULL,
		[UrlSeccion] [varchar](250) NULL,
		[DesktopOrdenBpt] [int] NOT NULL,
		[MobileOrdenBpt] [int] NOT NULL
	)

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_ConfiguracionPaisID]  DEFAULT ((0)) FOR [ConfiguracionPaisID]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_CampaniaID]  DEFAULT ((0)) FOR [CampaniaID]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopOrden]  DEFAULT ((0)) FOR [DesktopOrden]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileOrden]  DEFAULT ((0)) FOR [MobileOrden]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopTipoPresentacion]  DEFAULT ((0)) FOR [DesktopTipoPresentacion]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileTipoPresentacion]  DEFAULT ((0)) FOR [MobileTipoPresentacion]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopCantidadProductos]  DEFAULT ((0)) FOR [DesktopCantidadProductos]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileCantidadProductos]  DEFAULT ((0)) FOR [MobileCantidadProductos]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopActivo]  DEFAULT ((0)) FOR [DesktopActivo]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileActivo]  DEFAULT ((0)) FOR [MobileActivo]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopOrdenBpt]  DEFAULT ((0)) FOR [DesktopOrdenBpt]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileOrdenBpt]  DEFAULT ((0)) FOR [MobileOrdenBpt]

END

GO

/*end*/

USE BelcorpBolivia
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD TienePerfil BIT CONSTRAINT CON_ConfiguracionPais_False DEFAULT 'FALSE';
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesdeCampania'
)
BEGIN	
	ALTER TABLE ConfiguracionPais
	ADD DesdeCampania INT CONSTRAINT CON_ConfiguracionPais_Desde DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileTituloMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Logo'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD Logo VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Orden'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD Orden INT CONSTRAINT CON_ConfiguracionPais_Orden DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileTituloBanner VARCHAR(255);
END
GO
IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopSubTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopSubTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileSubTituloBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileSubTituloBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopFondoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopFondoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileFondoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileFondoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopLogoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD DesktopLogoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileLogoBanner'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD MobileLogoBanner VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'UrlMenu'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD UrlMenu VARCHAR(255);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'OrdenBpt'
)
BEGIN
	ALTER TABLE ConfiguracionPais
	ADD OrdenBpt int CONSTRAINT CON_ConfiguracionPais_OrdenBpt DEFAULT(0);
END
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.Objects 
  WHERE  Object_id = OBJECT_ID(N'dbo.ConfiguracionOfertasHome') AND Type = N'U'
)
BEGIN
	CREATE TABLE [dbo].[ConfiguracionOfertasHome](
		[ConfiguracionOfertasHomeID] [int] IDENTITY(1,1) NOT NULL,
		[ConfiguracionPaisID] [int] NOT NULL,
		[CampaniaID] [int] NOT NULL,
		[DesktopOrden] [int] NOT NULL,
		[MobileOrden] [int] NOT NULL,
		[DesktopImagenFondo] [varchar](250) NULL,
		[MobileImagenFondo] [varchar](250) NULL,
		[DesktopTitulo] [varchar](250) NULL,
		[MobileTitulo] [varchar](250) NULL,
		[DesktopSubTitulo] [varchar](250) NULL,
		[MobileSubTitulo] [varchar](250) NULL,
		[DesktopTipoPresentacion] [int] NOT NULL,
		[MobileTipoPresentacion] [int] NOT NULL,
		[DesktopTipoEstrategia] [varchar](250) NULL,
		[MobileTipoEstrategia] [varchar](250) NULL,
		[DesktopCantidadProductos] [int] NOT NULL,
		[MobileCantidadProductos] [int] NOT NULL,
		[DesktopActivo] [bit] NOT NULL,
		[MobileActivo] [bit] NOT NULL,
		[UrlSeccion] [varchar](250) NULL,
		[DesktopOrdenBpt] [int] NOT NULL,
		[MobileOrdenBpt] [int] NOT NULL
	)

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_ConfiguracionPaisID]  DEFAULT ((0)) FOR [ConfiguracionPaisID]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_CampaniaID]  DEFAULT ((0)) FOR [CampaniaID]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopOrden]  DEFAULT ((0)) FOR [DesktopOrden]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileOrden]  DEFAULT ((0)) FOR [MobileOrden]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopTipoPresentacion]  DEFAULT ((0)) FOR [DesktopTipoPresentacion]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileTipoPresentacion]  DEFAULT ((0)) FOR [MobileTipoPresentacion]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopCantidadProductos]  DEFAULT ((0)) FOR [DesktopCantidadProductos]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileCantidadProductos]  DEFAULT ((0)) FOR [MobileCantidadProductos]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopActivo]  DEFAULT ((0)) FOR [DesktopActivo]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileActivo]  DEFAULT ((0)) FOR [MobileActivo]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_DesktopOrdenBpt]  DEFAULT ((0)) FOR [DesktopOrdenBpt]

	ALTER TABLE [dbo].[ConfiguracionOfertasHome] ADD  CONSTRAINT [DF_ConfiguracionOfertasHome_MobileOrdenBpt]  DEFAULT ((0)) FOR [MobileOrdenBpt]

END

GO

/*end*/