USE BelcorpPeru_PL50
GO

IF COL_LENGTH('ConfiguracionOfertasHome', 'DesktopColorFondo') IS NOT NULL
BEGIN
    ALTER TABLE ConfiguracionOfertasHome DROP COLUMN DesktopColorFondo
END
GO

IF COL_LENGTH('ConfiguracionOfertasHome', 'MobileColorFondo') IS NOT NULL
BEGIN
    ALTER TABLE ConfiguracionOfertasHome DROP COLUMN MobileColorFondo
END
GO

IF COL_LENGTH('ConfiguracionOfertasHome', 'DesktopUsarImagenFondo') IS NOT NULL
BEGIN
    ALTER TABLE ConfiguracionOfertasHome DROP COLUMN DesktopUsarImagenFondo
END
GO

IF COL_LENGTH('ConfiguracionOfertasHome', 'MobileUsarImagenFondo') IS NOT NULL
BEGIN
    ALTER TABLE ConfiguracionOfertasHome DROP COLUMN MobileUsarImagenFondo
END
GO

IF COL_LENGTH('ConfiguracionOfertasHome', 'DesktopColorTexto') IS NOT NULL
BEGIN
    ALTER TABLE ConfiguracionOfertasHome DROP COLUMN DesktopColorTexto
END
GO

IF COL_LENGTH('ConfiguracionOfertasHome', 'MobileColorTexto') IS NOT NULL
BEGIN
    ALTER TABLE ConfiguracionOfertasHome DROP COLUMN MobileColorTexto
END
GO