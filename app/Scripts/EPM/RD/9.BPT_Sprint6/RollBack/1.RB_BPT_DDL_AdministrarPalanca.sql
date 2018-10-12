USE BelcorpPeru
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
begin

	ALTER TABLE ConfiguracionPais
	DROP CONSTRAINT [CON_ConfiguracionPais_False]

	ALTER TABLE ConfiguracionPais drop column TienePerfil

end

go

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesdeCampania'
)
BEGIN	
	
	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_Desde];

	ALTER TABLE ConfiguracionPais drop column DesdeCampania

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloMenu'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileTituloMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloMenu'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopTituloMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Logo'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column Logo

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Orden'
)
BEGIN

	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_Orden];

	ALTER TABLE ConfiguracionPais drop column Orden

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloBanner'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopSubTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopSubTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileSubTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column MobileSubTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopFondoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopFondoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileFondoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column MobileFondoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopLogoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopLogoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileLogoBanner'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileLogoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'UrlMenu'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column UrlMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'OrdenBpt'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_OrdenBpt];

	ALTER TABLE ConfiguracionPais drop column OrdenBpt

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.Objects 
  WHERE  Object_id = OBJECT_ID(N'dbo.ConfiguracionOfertasHome') AND Type = N'U'
)
begin

	drop table ConfiguracionOfertasHome

end

go

USE BelcorpMexico
go

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
begin

	ALTER TABLE ConfiguracionPais
	DROP CONSTRAINT [CON_ConfiguracionPais_False]

	ALTER TABLE ConfiguracionPais drop column TienePerfil

end

go

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesdeCampania'
)
BEGIN	
	
	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_Desde];

	ALTER TABLE ConfiguracionPais drop column DesdeCampania

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloMenu'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileTituloMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloMenu'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopTituloMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Logo'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column Logo

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Orden'
)
BEGIN

	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_Orden];

	ALTER TABLE ConfiguracionPais drop column Orden

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloBanner'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopSubTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopSubTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileSubTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column MobileSubTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopFondoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopFondoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileFondoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column MobileFondoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopLogoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopLogoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileLogoBanner'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileLogoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'UrlMenu'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column UrlMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'OrdenBpt'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_OrdenBpt];

	ALTER TABLE ConfiguracionPais drop column OrdenBpt

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.Objects 
  WHERE  Object_id = OBJECT_ID(N'dbo.ConfiguracionOfertasHome') AND Type = N'U'
)
begin

	drop table ConfiguracionOfertasHome

end

go

USE BelcorpColombia
go

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
begin

	ALTER TABLE ConfiguracionPais
	DROP CONSTRAINT [CON_ConfiguracionPais_False]

	ALTER TABLE ConfiguracionPais drop column TienePerfil

end

go

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesdeCampania'
)
BEGIN	
	
	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_Desde];

	ALTER TABLE ConfiguracionPais drop column DesdeCampania

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloMenu'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileTituloMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloMenu'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopTituloMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Logo'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column Logo

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Orden'
)
BEGIN

	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_Orden];

	ALTER TABLE ConfiguracionPais drop column Orden

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloBanner'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopSubTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopSubTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileSubTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column MobileSubTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopFondoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopFondoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileFondoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column MobileFondoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopLogoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopLogoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileLogoBanner'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileLogoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'UrlMenu'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column UrlMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'OrdenBpt'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_OrdenBpt];

	ALTER TABLE ConfiguracionPais drop column OrdenBpt

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.Objects 
  WHERE  Object_id = OBJECT_ID(N'dbo.ConfiguracionOfertasHome') AND Type = N'U'
)
begin

	drop table ConfiguracionOfertasHome

end

go

USE BelcorpVenezuela
go

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
begin

	ALTER TABLE ConfiguracionPais
	DROP CONSTRAINT [CON_ConfiguracionPais_False]

	ALTER TABLE ConfiguracionPais drop column TienePerfil

end

go

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesdeCampania'
)
BEGIN	
	
	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_Desde];

	ALTER TABLE ConfiguracionPais drop column DesdeCampania

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloMenu'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileTituloMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloMenu'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopTituloMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Logo'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column Logo

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Orden'
)
BEGIN

	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_Orden];

	ALTER TABLE ConfiguracionPais drop column Orden

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloBanner'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopSubTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopSubTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileSubTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column MobileSubTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopFondoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopFondoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileFondoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column MobileFondoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopLogoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopLogoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileLogoBanner'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileLogoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'UrlMenu'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column UrlMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'OrdenBpt'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_OrdenBpt];

	ALTER TABLE ConfiguracionPais drop column OrdenBpt

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.Objects 
  WHERE  Object_id = OBJECT_ID(N'dbo.ConfiguracionOfertasHome') AND Type = N'U'
)
begin

	drop table ConfiguracionOfertasHome

end

go

USE BelcorpSalvador
go

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
begin

	ALTER TABLE ConfiguracionPais
	DROP CONSTRAINT [CON_ConfiguracionPais_False]

	ALTER TABLE ConfiguracionPais drop column TienePerfil

end

go

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesdeCampania'
)
BEGIN	
	
	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_Desde];

	ALTER TABLE ConfiguracionPais drop column DesdeCampania

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloMenu'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileTituloMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloMenu'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopTituloMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Logo'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column Logo

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Orden'
)
BEGIN

	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_Orden];

	ALTER TABLE ConfiguracionPais drop column Orden

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloBanner'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopSubTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopSubTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileSubTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column MobileSubTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopFondoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopFondoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileFondoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column MobileFondoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopLogoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopLogoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileLogoBanner'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileLogoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'UrlMenu'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column UrlMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'OrdenBpt'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_OrdenBpt];

	ALTER TABLE ConfiguracionPais drop column OrdenBpt

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.Objects 
  WHERE  Object_id = OBJECT_ID(N'dbo.ConfiguracionOfertasHome') AND Type = N'U'
)
begin

	drop table ConfiguracionOfertasHome

end

go

USE BelcorpPuertoRico
go

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
begin

	ALTER TABLE ConfiguracionPais
	DROP CONSTRAINT [CON_ConfiguracionPais_False]

	ALTER TABLE ConfiguracionPais drop column TienePerfil

end

go

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesdeCampania'
)
BEGIN	
	
	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_Desde];

	ALTER TABLE ConfiguracionPais drop column DesdeCampania

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloMenu'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileTituloMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloMenu'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopTituloMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Logo'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column Logo

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Orden'
)
BEGIN

	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_Orden];

	ALTER TABLE ConfiguracionPais drop column Orden

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloBanner'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopSubTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopSubTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileSubTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column MobileSubTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopFondoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopFondoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileFondoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column MobileFondoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopLogoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopLogoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileLogoBanner'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileLogoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'UrlMenu'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column UrlMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'OrdenBpt'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_OrdenBpt];

	ALTER TABLE ConfiguracionPais drop column OrdenBpt

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.Objects 
  WHERE  Object_id = OBJECT_ID(N'dbo.ConfiguracionOfertasHome') AND Type = N'U'
)
begin

	drop table ConfiguracionOfertasHome

end

go

USE BelcorpPanama
go

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
begin

	ALTER TABLE ConfiguracionPais
	DROP CONSTRAINT [CON_ConfiguracionPais_False]

	ALTER TABLE ConfiguracionPais drop column TienePerfil

end

go

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesdeCampania'
)
BEGIN	
	
	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_Desde];

	ALTER TABLE ConfiguracionPais drop column DesdeCampania

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloMenu'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileTituloMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloMenu'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopTituloMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Logo'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column Logo

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Orden'
)
BEGIN

	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_Orden];

	ALTER TABLE ConfiguracionPais drop column Orden

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloBanner'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopSubTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopSubTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileSubTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column MobileSubTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopFondoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopFondoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileFondoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column MobileFondoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopLogoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopLogoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileLogoBanner'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileLogoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'UrlMenu'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column UrlMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'OrdenBpt'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_OrdenBpt];

	ALTER TABLE ConfiguracionPais drop column OrdenBpt

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.Objects 
  WHERE  Object_id = OBJECT_ID(N'dbo.ConfiguracionOfertasHome') AND Type = N'U'
)
begin

	drop table ConfiguracionOfertasHome

end

go

USE BelcorpGuatemala
go

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
begin

	ALTER TABLE ConfiguracionPais
	DROP CONSTRAINT [CON_ConfiguracionPais_False]

	ALTER TABLE ConfiguracionPais drop column TienePerfil

end

go

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesdeCampania'
)
BEGIN	
	
	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_Desde];

	ALTER TABLE ConfiguracionPais drop column DesdeCampania

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloMenu'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileTituloMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloMenu'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopTituloMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Logo'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column Logo

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Orden'
)
BEGIN

	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_Orden];

	ALTER TABLE ConfiguracionPais drop column Orden

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloBanner'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopSubTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopSubTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileSubTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column MobileSubTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopFondoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopFondoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileFondoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column MobileFondoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopLogoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopLogoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileLogoBanner'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileLogoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'UrlMenu'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column UrlMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'OrdenBpt'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_OrdenBpt];

	ALTER TABLE ConfiguracionPais drop column OrdenBpt

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.Objects 
  WHERE  Object_id = OBJECT_ID(N'dbo.ConfiguracionOfertasHome') AND Type = N'U'
)
begin

	drop table ConfiguracionOfertasHome

end

go

USE BelcorpEcuador
go

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
begin

	ALTER TABLE ConfiguracionPais
	DROP CONSTRAINT [CON_ConfiguracionPais_False]

	ALTER TABLE ConfiguracionPais drop column TienePerfil

end

go

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesdeCampania'
)
BEGIN	
	
	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_Desde];

	ALTER TABLE ConfiguracionPais drop column DesdeCampania

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloMenu'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileTituloMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloMenu'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopTituloMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Logo'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column Logo

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Orden'
)
BEGIN

	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_Orden];

	ALTER TABLE ConfiguracionPais drop column Orden

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloBanner'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopSubTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopSubTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileSubTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column MobileSubTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopFondoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopFondoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileFondoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column MobileFondoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopLogoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopLogoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileLogoBanner'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileLogoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'UrlMenu'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column UrlMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'OrdenBpt'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_OrdenBpt];

	ALTER TABLE ConfiguracionPais drop column OrdenBpt

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.Objects 
  WHERE  Object_id = OBJECT_ID(N'dbo.ConfiguracionOfertasHome') AND Type = N'U'
)
begin

	drop table ConfiguracionOfertasHome

end

go

USE BelcorpDominicana
go

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
begin

	ALTER TABLE ConfiguracionPais
	DROP CONSTRAINT [CON_ConfiguracionPais_False]

	ALTER TABLE ConfiguracionPais drop column TienePerfil

end

go

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesdeCampania'
)
BEGIN	
	
	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_Desde];

	ALTER TABLE ConfiguracionPais drop column DesdeCampania

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloMenu'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileTituloMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloMenu'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopTituloMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Logo'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column Logo

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Orden'
)
BEGIN

	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_Orden];

	ALTER TABLE ConfiguracionPais drop column Orden

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloBanner'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopSubTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopSubTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileSubTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column MobileSubTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopFondoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopFondoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileFondoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column MobileFondoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopLogoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopLogoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileLogoBanner'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileLogoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'UrlMenu'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column UrlMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'OrdenBpt'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_OrdenBpt];

	ALTER TABLE ConfiguracionPais drop column OrdenBpt

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.Objects 
  WHERE  Object_id = OBJECT_ID(N'dbo.ConfiguracionOfertasHome') AND Type = N'U'
)
begin

	drop table ConfiguracionOfertasHome

end

go

USE BelcorpCostaRica
go

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
begin

	ALTER TABLE ConfiguracionPais
	DROP CONSTRAINT [CON_ConfiguracionPais_False]

	ALTER TABLE ConfiguracionPais drop column TienePerfil

end

go

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesdeCampania'
)
BEGIN	
	
	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_Desde];

	ALTER TABLE ConfiguracionPais drop column DesdeCampania

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloMenu'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileTituloMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloMenu'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopTituloMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Logo'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column Logo

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Orden'
)
BEGIN

	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_Orden];

	ALTER TABLE ConfiguracionPais drop column Orden

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloBanner'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopSubTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopSubTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileSubTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column MobileSubTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopFondoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopFondoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileFondoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column MobileFondoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopLogoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopLogoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileLogoBanner'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileLogoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'UrlMenu'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column UrlMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'OrdenBpt'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_OrdenBpt];

	ALTER TABLE ConfiguracionPais drop column OrdenBpt

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.Objects 
  WHERE  Object_id = OBJECT_ID(N'dbo.ConfiguracionOfertasHome') AND Type = N'U'
)
begin

	drop table ConfiguracionOfertasHome

end

go

USE BelcorpChile
go

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
begin

	ALTER TABLE ConfiguracionPais
	DROP CONSTRAINT [CON_ConfiguracionPais_False]

	ALTER TABLE ConfiguracionPais drop column TienePerfil

end

go

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesdeCampania'
)
BEGIN	
	
	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_Desde];

	ALTER TABLE ConfiguracionPais drop column DesdeCampania

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloMenu'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileTituloMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloMenu'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopTituloMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Logo'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column Logo

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Orden'
)
BEGIN

	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_Orden];

	ALTER TABLE ConfiguracionPais drop column Orden

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloBanner'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopSubTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopSubTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileSubTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column MobileSubTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopFondoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopFondoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileFondoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column MobileFondoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopLogoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopLogoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileLogoBanner'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileLogoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'UrlMenu'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column UrlMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'OrdenBpt'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_OrdenBpt];

	ALTER TABLE ConfiguracionPais drop column OrdenBpt

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.Objects 
  WHERE  Object_id = OBJECT_ID(N'dbo.ConfiguracionOfertasHome') AND Type = N'U'
)
begin

	drop table ConfiguracionOfertasHome

end

go

USE BelcorpBolivia
go

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'TienePerfil'
)
begin

	ALTER TABLE ConfiguracionPais
	DROP CONSTRAINT [CON_ConfiguracionPais_False]

	ALTER TABLE ConfiguracionPais drop column TienePerfil

end

go

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesdeCampania'
)
BEGIN	
	
	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_Desde];

	ALTER TABLE ConfiguracionPais drop column DesdeCampania

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloMenu'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileTituloMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloMenu'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopTituloMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Logo'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column Logo

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'Orden'
)
BEGIN

	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_Orden];

	ALTER TABLE ConfiguracionPais drop column Orden

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileTituloBanner'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopSubTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopSubTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileSubTituloBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column MobileSubTituloBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopFondoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopFondoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileFondoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column MobileFondoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'DesktopLogoBanner'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais drop column DesktopLogoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'MobileLogoBanner'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column MobileLogoBanner

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'UrlMenu'
)
BEGIN

	ALTER TABLE ConfiguracionPais drop column UrlMenu

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[ConfiguracionPais]') 
         AND name = 'OrdenBpt'
)
BEGIN
	
	ALTER TABLE ConfiguracionPais	
	DROP CONSTRAINT [CON_ConfiguracionPais_OrdenBpt];

	ALTER TABLE ConfiguracionPais drop column OrdenBpt

END
GO

IF EXISTS (
  SELECT * 
  FROM   sys.Objects 
  WHERE  Object_id = OBJECT_ID(N'dbo.ConfiguracionOfertasHome') AND Type = N'U'
)
begin

	drop table ConfiguracionOfertasHome

end

go