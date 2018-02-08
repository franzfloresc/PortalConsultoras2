USE BelcorpPeru_PL50
GO

IF COL_LENGTH('ConfiguracionOfertasHome', 'DesktopColorFondo') IS NULL
BEGIN
    ALTER TABLE ConfiguracionOfertasHome ADD DesktopColorFondo VARCHAR(10) NULL
END
GO

IF COL_LENGTH('ConfiguracionOfertasHome', 'MobileColorFondo') IS NULL
BEGIN
    ALTER TABLE ConfiguracionOfertasHome ADD MobileColorFondo VARCHAR(10) NULL
END
GO

IF COL_LENGTH('ConfiguracionOfertasHome', 'DesktopUsarImagenFondo') IS NULL
BEGIN
    ALTER TABLE ConfiguracionOfertasHome ADD DesktopUsarImagenFondo BIT NULL
END
GO

IF COL_LENGTH('ConfiguracionOfertasHome', 'MobileUsarImagenFondo') IS NULL
BEGIN
    ALTER TABLE ConfiguracionOfertasHome ADD MobileUsarImagenFondo BIT NULL
END
GO

IF COL_LENGTH('ConfiguracionOfertasHome', 'DesktopColorTexto') IS NULL
BEGIN
    ALTER TABLE ConfiguracionOfertasHome ADD DesktopColorTexto VARCHAR(10) NULL
END
GO

IF COL_LENGTH('ConfiguracionOfertasHome', 'MobileColorTexto') IS NULL
BEGIN
    ALTER TABLE ConfiguracionOfertasHome ADD MobileColorTexto VARCHAR(10) NULL
END
GO